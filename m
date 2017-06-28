Received: from eggs.gnu.org ([2001:4830:134:3::10]:44909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQAzy-0006dw-VI
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQAzy-0005va-6w
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:19:06 -0400
Date: Wed, 28 Jun 2017 13:18:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170628111854.GC5378@noname.redhat.com>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-9-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170623124700.1389-9-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH RFC v3 8/8] block: add throttle block
 filter driver interface tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

Am 23.06.2017 um 14:47 hat Manos Pitsidianakis geschrieben:
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

This one doesn't apply because the reference output contains a too long
line and a newline was inserted. I think QMP pretty printing can help to
avoid overly long lines.

Kevin
