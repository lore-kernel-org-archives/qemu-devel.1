Received: from eggs.gnu.org ([209.51.188.92]:46414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1h1XYe-0004ox-Oy
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1h1XYe-00041E-0a
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:30:08 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a]:42699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1h1XYd-0003zw-FM
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:30:07 -0500
Received: by mail-qt1-x82a.google.com with SMTP id u7so12983846qtg.9
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 06:30:07 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <f08e6be0-68c5-a7fe-8877-7dad0eb5929d@vivier.eu>
Date: Wed, 6 Mar 2019 09:30:03 -0500
Content-Transfer-Encoding: 7bit
Message-Id: <290F879D-78DA-48B1-9246-4DB75DC3886D@oberlin.edu>
References: <20190219153727.62279-1-stephen.checkoway@oberlin.edu>
	<f08e6be0-68c5-a7fe-8877-7dad0eb5929d@vivier.eu>
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] block/pflash_cfi02: Fix
 memory leak and potential use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>



> On Mar 6, 2019, at 04:38, Laurent Vivier <laurent@vivier.eu> wrote:
> 
> Applied to my trivial-patches branch.

Great, thanks!

Cheers,

Steve
