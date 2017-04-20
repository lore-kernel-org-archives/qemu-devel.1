Received: from eggs.gnu.org ([2001:4830:134:3::10]:50323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d16VA-0000iF-IK
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d16V7-00082n-Dc
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:27:40 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42492
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d16V7-0007zf-6c
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:27:37 -0400
References: <5a275226-bce0-4c8f-a708-063245cfe8f2@Spark>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <583d86e4-dc32-ca67-6157-2b4c1654a758@ilande.co.uk>
Date: Thu, 20 Apr 2017 08:26:56 +0100
MIME-Version: 1.0
In-Reply-To: <5a275226-bce0-4c8f-a708-063245cfe8f2@Spark>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ajallooiean Hossein <hossein.ajallooiean@epfl.ch>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 20/04/17 06:25, Ajallooiean Hossein wrote:

> Hi All
> 
> Has anyone experienced any kernel panics with the Sparc64 in 2.9-rc4? I dont seem to be able to run it right out of the box.
> 
> Ill appreciate any kind of help
> 
> Regards
> -H

I have a range of test images that I boot on a regular basis for
qemu-system-sparc64 with success. Can you provide the full command line,
QEMU version, and the output of the panic?


ATB,

Mark.
