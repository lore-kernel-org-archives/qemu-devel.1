Received: from eggs.gnu.org ([2001:4830:134:3::10]:60474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e7i86-0004fU-MH
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e7i82-0005H2-3j
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:23:26 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170929165347.29658-7-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-7-mreitz@redhat.com>
Date: Thu, 26 Oct 2017 15:23:15 +0200
Message-ID: <w51r2tqxcu4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 06/25] block:
 bdrv_get_full_backing_filename_from_...'s ret. val.
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

On Fri 29 Sep 2017 06:53:28 PM CEST, Max Reitz <mreitz@redhat.com> wrote:
> Make bdrv_get_full_backing_filename_from_filename() return an allocated
> string instead of placing the result in a caller-provided buffer.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
