Received: from eggs.gnu.org ([2001:4830:134:3::10]:44101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMH2W-0007u2-DB
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMH2T-0005bB-Au
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:25:20 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:48669 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMH2S-0005b4-T7
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:25:17 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148294074463.127.13007157172340216335@790289a7ca88>
Date: Wed, 28 Dec 2016 17:25:15 +0100
In-Reply-To: <148294074463.127.13007157172340216335@790289a7ca88>
	(no-reply@patchew.org's message of "Wed, 28 Dec 2016 07:59:05 -0800
	(PST)")
Message-ID: <87lgv0nhqs.fsf@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH v4 0/6] translate: [tcg] Generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, famz@redhat.com, crosthwaite.peter@gmail.com

no-reply  writes:

> Hi,
> Your series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.

I did try to compile all targets and it works for me (gcc 6.2.1). I've also
tried the oldest gcc I have (4.8.4) and it fails to link all programs on vanilla
QEMU, but compiles all the files otherwise (including my series).


Cheers,
  Lluis
