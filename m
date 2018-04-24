Received: from eggs.gnu.org ([2001:4830:134:3::10]:43673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fAzhI-0003ab-Af
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fAzhH-0004CY-4U
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:17:36 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180421132929.21610-9-mreitz@redhat.com>
References: <20180421132929.21610-1-mreitz@redhat.com>
	<20180421132929.21610-9-mreitz@redhat.com>
Date: Tue, 24 Apr 2018 17:17:27 +0200
Message-ID: <w51fu3k63co.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 8/9] iotests: Copy 197 for COR filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Sat 21 Apr 2018 03:29:28 PM CEST, Max Reitz wrote:
> iotest 197 tests copy-on-read using the (now old) copy-on-read flag.
> Copy it to 215 and modify it to use the COR filter driver instead.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
