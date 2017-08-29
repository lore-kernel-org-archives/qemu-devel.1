Received: from eggs.gnu.org ([2001:4830:134:3::10]:55015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmcw4-0003vB-Lh
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmcw1-0000Or-FM
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:35:52 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dmcw1-0000OS-8K
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:35:49 -0400
Received: by mail-wm0-x243.google.com with SMTP id e67so3123047wmd.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 02:35:49 -0700 (PDT)
Date: Tue, 29 Aug 2017 10:35:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170829093546.GG25960@stefanha-x1.localdomain>
References: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
	<20170828015654.2530-8-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828015654.2530-8-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 07/14] hvf: run hvf code through
 checkpatch.pl and fix style issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Sun, Aug 27, 2017 at 08:56:47PM -0500, Sergio Andres Gomez Del Real wrote:
> Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

Please make this the 2nd patch so there are no other patches in between
that modify code that violates coding style.
