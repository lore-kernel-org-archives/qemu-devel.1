Received: from eggs.gnu.org ([2001:4830:134:3::10]:51560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUwjw-0001ZX-SF
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUwjw-0001tt-3h
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:06:16 -0400
Date: Tue, 11 Jul 2017 17:06:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170711150609.GJ4335@noname.str.redhat.com>
References: <20170702100646.20656-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170702100646.20656-1-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 0/2] ThrottleGroup configuration fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 02.07.2017 um 12:06 hat Manos Pitsidianakis geschrieben:
> Since in the future ThrottleGroup configuration will be done even if it
> has no members, we need to separate the two.

Thanks, applied to the block branch.

Kevin
