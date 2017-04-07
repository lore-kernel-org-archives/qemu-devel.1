Received: from eggs.gnu.org ([2001:4830:134:3::10]:32892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1cwqfu-0003bo-6D
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 09:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1cwqft-00033z-F8
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 09:45:10 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Fri, 7 Apr 2017 20:11:33 +0000
Message-ID: <AM5P194MB012946E7708F112D8F8327E6C80C0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
References: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
	<AM5P194MB01294EAC74E1825F9210E04CC80C0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>,
	<2883915A-A579-4BC2-9FBE-5D885B88AF22@gmail.com>
In-Reply-To: <2883915A-A579-4BC2-9FBE-5D885B88AF22@gmail.com>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "rth@twiddle.net" <rth@twiddle.net>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>

Hi i dint made much tests,

but for sure all is faster compared one thread only.

Fore sure tcg need to be optimized (in all emulated architectures) compared=
 some old commercial emulators but all is better than before.

I will made more tests tomorrow and report.

ciao

Luigi


Do you have any timings? Did the guest run faster?
