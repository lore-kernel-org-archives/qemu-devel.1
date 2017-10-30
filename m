Received: from eggs.gnu.org ([2001:4830:134:3::10]:38826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9B1M-0003wv-RO
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9B1M-0008Iq-4d
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:26:32 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170929165347.29658-9-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-9-mreitz@redhat.com>
Date: Mon, 30 Oct 2017 15:25:49 +0100
Message-ID: <w51k1zck902.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 08/25] block: Add
 bdrv_make_absolute_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Fri 29 Sep 2017 06:53:30 PM CEST, Max Reitz wrote:
> This is a general function for making a filename that is relative to a
> certain BDS absolute.
>
> It calls bdrv_get_full_backing_filename_from_filename() for now, but
> that will be changed in a follow-up patch.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
