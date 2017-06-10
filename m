Received: from eggs.gnu.org ([2001:4830:134:3::10]:49585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJgUw-0000Bo-3e
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 09:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJgUt-0003MB-2o
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 09:32:14 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33478
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dJgUs-0003Lw-Ri
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 09:32:11 -0400
References: <149710124565.5184.589786790726488850@84b42461e25a>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ec44cfad-92a4-664a-4c05-39941bc31480@ilande.co.uk>
Date: Sat, 10 Jun 2017 14:31:55 +0100
MIME-Version: 1.0
In-Reply-To: <149710124565.5184.589786790726488850@84b42461e25a>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] sun4u: move fw_cfg/NVRAM devices to
 ebus PCI IO address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, atar4qemu@gmail.com

On 10/06/17 14:27, no-reply@patchew.org wrote:

> Hi,
> 
> This series failed build test on s390x host. Please find the details below.

Well given that it's dependent upon the fw_cfg patchset I posted
earlier, it's probably going to fail on all hosts :)

Is there a way to express patch dependencies for the patchew builds that
I'm not aware of?


ATB,

Mark.
