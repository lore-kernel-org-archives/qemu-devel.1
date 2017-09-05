Received: from eggs.gnu.org ([2001:4830:134:3::10]:36057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpEQC-0000DY-Go
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpEQ3-0003Bk-0d
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:01:44 -0400
Date: Tue, 5 Sep 2017 15:01:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170905140117.GQ17449@stefanha-x1.localdomain>
References: <20170825132028.6184-1-el13635@mail.ntua.gr>
	<20170825132028.6184-7-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825132028.6184-7-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v9 6/6] qemu-iotests: add 184 for throttle
 filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

On Fri, Aug 25, 2017 at 04:20:28PM +0300, Manos Pitsidianakis wrote:
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  tests/qemu-iotests/184     | 205 +++++++++++++++++++++++++++++++
>  tests/qemu-iotests/184.out | 300 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 506 insertions(+)
>  create mode 100755 tests/qemu-iotests/184
>  create mode 100644 tests/qemu-iotests/184.out

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
