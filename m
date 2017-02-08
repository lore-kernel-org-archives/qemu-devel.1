Received: from eggs.gnu.org ([2001:4830:134:3::10]:42282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cbU9W-0000lT-HT
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 10:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cbU9R-0007OL-Js
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 10:27:26 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170126101827.22378-2-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-2-berrange@redhat.com>
Date: Wed, 08 Feb 2017 16:26:42 +0100
Message-ID: <w51poissnyl.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 01/18] block: expose crypto
 option names / defs to other drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 26 Jan 2017 11:18:10 AM CET, Daniel P. Berrange wrote:
> The block/crypto.c defines a set of QemuOpts that provide
> parameters for encryption. This will also be needed by
> the qcow/qcow2 integration, so expose the relevant pieces
> in a new block/crypto.h header.
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
