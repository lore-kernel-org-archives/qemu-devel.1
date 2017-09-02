Received: from eggs.gnu.org ([2001:4830:134:3::10]:59796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1doBvV-0001rT-U8
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 13:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1doBvR-0005uf-5E
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 13:09:45 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Sat, 2 Sep 2017 17:09:28 +0000
Message-ID: <AM5P194MB01329E868116B28535E050A3C8930@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] e5500 pcce500 disabled network and no video on device
 virtio-gpu or virtio gpu-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

Hi all,

like the topic i cant made the machine goes online plus the video output do=
n work.

on this email i made the links with

kernel 411 with virtio,bochs etc etc .

a base of distro with kernel modules

my usual lines configuration.


Note i tested all on real e5500 machine and all is working there.

Hope my job will help in fixing and developing


ubuntu base : https://www.dropbox.com/s/yzp657yad3cp48n/Amigaone_Ubuntu_16.=
04-Base-1.img.gz?dl=3D0


Kernel 411:https://www.dropbox.com/s/ne49j5bo62680l0/u411.gz?dl=3D0


qemu line config: https://www.dropbox.com/s/j5kekeut75ogs9r/qemu_config.gz?=
dl=3D0


Thanks

Luigi
