Received: from eggs.gnu.org ([2001:4830:134:3::10]:42906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1egutW-0000gr-G2
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1egutT-0008Fm-5o
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:05:54 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180120154412.9990-4-mreitz@redhat.com>
References: <20180120154412.9990-1-mreitz@redhat.com>
	<20180120154412.9990-4-mreitz@redhat.com>
Date: Wed, 31 Jan 2018 17:05:40 +0100
Message-ID: <w51po5qxbcb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: Remove qobject_to_X()
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Sat 20 Jan 2018 04:44:09 PM CET, Max Reitz wrote:
> They are no longer needed now.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
