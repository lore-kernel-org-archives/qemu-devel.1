Received: from eggs.gnu.org ([2001:4830:134:3::10]:52942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPajN-00006Z-2o
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPajM-0008G9-7J
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:12:20 -0500
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<85a3fe487514f4cb659ef7e6b88762ebc567c1b8.1542819633.git.alistair.francis@wdc.com>
	<e7398997-ba1a-9182-6be0-da8e43e920df@deltatee.com>
	<CAKmqyKMtTqi=D-PKZFnt40MaA8+e6Sj8nUr0VmBFajScw1MYng@mail.gmail.com>
	<ffd80fff-55bf-0578-4fe5-00f07ef6bdc6@deltatee.com>
	<CAKmqyKMhpAPXFF5cQkqKYcNjD5aciDW7Ek53+W=1XNp3RGFLmw@mail.gmail.com>
	<33646fef-adb7-26b4-ba01-79f9a0f5bdae@deltatee.com>
	<CAKmqyKMJvTb=JebfA1N-40-MqgHkAj98JOH51t6K--zjYLXSnA@mail.gmail.com>
	<d316a936-c726-dd4c-f90a-9690b4e3fc3d@deltatee.com>
	<CAKmqyKM1pf1zJVMuqZvocN07LxDGrRjoSNLojt=06UbN4P-bpg@mail.gmail.com>
	<6480496b-dbb5-37bb-57e2-7a4819c61511@deltatee.com>
	<CAKmqyKMPHg7nGr-Ua1Cb7yvdZzWAs6HOM4eB+SinMypXQ5Ni6w@mail.gmail.com>
	<CAKmqyKMTiMJKCc=oEP97XLWFQMMfE0PFHB8ZKGm2=AP5_HEoNg@mail.gmail.com>
	<00f7a2ba-8eb1-77fd-1c4b-14e83e553bed@deltatee.com>
	<CAKmqyKOVKd0Wn1+t1rFbFJX3q3TQjovKVQ1_cC5P9oXHD_ZMpQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bcc28264-33e2-6df0-c486-3f72cabeee48@deltatee.com>
Date: Wed, 21 Nov 2018 15:11:59 -0700
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOVKd0Wn1+t1rFbFJX3q3TQjovKVQ1_cC5P9oXHD_ZMpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 5/6] hw/riscv/sifive_u: Connect
 the Xilinx PCIe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org, Guenter Roeck <linux@roeck-us.net>, Andrea Bolognani <abologna@redhat.com>



On 2018-11-21 3:09 p.m., Alistair Francis wrote:
> Yeah, it's a real pain. I had a go at adding the SD card [1] but never
> got it fully working. Normally I just hack in the virtIO MMIO regions
> and use those.
> 
> 1: https://github.com/alistair23/qemu/tree/mainline/alistair/sifive_spi.next
>     I just did a quick rebase, fully untested

Ah, so very much work in progress. I'll stick with the virt machine for
the time being.

Thanks,

Logan
