Received: from eggs.gnu.org ([2001:4830:134:3::10]:47153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dmGP7-0007YW-Lf
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dmGP2-0000V5-Jn
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:32:21 -0400
Date: Mon, 28 Aug 2017 11:32:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170828113212.53d8cac1@nial.brq.redhat.com>
In-Reply-To: <AM5P194MB013219B88ABEA53957934752C89E0@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
References: <mailman.4191.1503853034.21953.qemu-ppc@nongnu.org>
	<AC464994-B6AC-4DBC-942D-8C5EA8ECCE0E@gmail.com>
	<AM5P194MB0132478A4ED8333EA2FFA940C89E0@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
	<20170828111039.4b5a280a@nial.brq.redhat.com>
	<AM5P194MB013219B88ABEA53957934752C89E0@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Qemu 2.10 rc4 build issue on BE (luigi burdo)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>
Cc: Programmingkid <programmingkidx@gmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On Mon, 28 Aug 2017 09:14:48 +0000
luigi burdo <intermediadc@hotmail.com> wrote:

> Hi Igor,
> 
> 
> below errors look like corrupted source files
> 
> >  
> 
> 
> i ust dowloaded the compressed file from qemu website,unzipped with tar from console (like i usually did)  and run configure and make.
> 
> can be the file of rc4 from qemu website not right and need a repack?
I've just downloaded it from http://download.qemu-project.org/qemu-2.10.0-rc4.tar.xz
and unpacked, it works for me (i.e. hw/i386/pc.c isn't corrupted).

> 
> Luigi
> 
