Received: from eggs.gnu.org ([2001:4830:134:3::10]:50717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmGiK-0003JB-AN
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmGiH-0001Ql-8S
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:52:12 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170825132028.6184-5-el13635@mail.ntua.gr>
References: <20170825132028.6184-1-el13635@mail.ntua.gr>
	<20170825132028.6184-5-el13635@mail.ntua.gr>
Date: Mon, 28 Aug 2017 11:52:05 +0200
Message-ID: <w51val8uiii.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 4/6] block: convert ThrottleGroup to
 object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri 25 Aug 2017 03:20:26 PM CEST, Manos Pitsidianakis wrote:
> ThrottleGroup is converted to an object. This will allow the future
> throttle block filter drive easy creation and configuration of throttle
> groups in QMP and cli.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
