Received: from eggs.gnu.org ([2001:4830:134:3::10]:44821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMH5a-0001Ff-Hr
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:28:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMH5X-00067Q-7F
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:28:30 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:48711 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMH5W-00067B-RN
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:28:27 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148294074463.127.13007157172340216335@790289a7ca88>
Date: Wed, 28 Dec 2016 17:28:25 +0100
In-Reply-To: <148294074463.127.13007157172340216335@790289a7ca88>
	(no-reply@patchew.org's message of "Wed, 28 Dec 2016 07:59:05 -0800
	(PST)")
Message-ID: <87ful8nhli.fsf@fimbulvetr.bsc.es>
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

Oh, my bad. Forgot to remove some of the "restrict" I added on previous
versions.

Thanks,
  Lluis
