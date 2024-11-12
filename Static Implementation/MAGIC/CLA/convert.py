import sys

def convert_spice_to_cir(input_file, output_file):
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        outfile.write(".include TSMC_180nm.txt\n")
        outfile.write(".param SUPPLY=1.8\n")
        outfile.write(".global gnd vdd\n\n")
        outfile.write("* Supply\n")
        outfile.write("Vdd vdd gnd 'SUPPLY'\n\n")
        
        for line in infile:
            line = line.replace('nfet', 'CMOSN')
            line = line.replace('pfet', 'CMOSP')
            line = line.replace('**FLOATING', ' ')
            if '.option scale=' in line:
                scale_value = line.split('=')[1].strip()
                if scale_value not in ['90n', '0.09u']:
                    line = '.option scale=0.09u\n'
            
            outfile.write(line)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python convert.py <input_file> <output_file> ")
        sys.exit(1)
    
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    
    convert_spice_to_cir(input_file, output_file)
    print(f"Conversion complete. {output_file}")