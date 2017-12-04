Received: from eggs.gnu.org ([2001:4830:134:3::10]:57201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eLtss-0001L5-N3
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eLtsn-0000aJ-SW
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:46:22 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171120201004.14999-26-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-26-mreitz@redhat.com>
Date: Mon, 04 Dec 2017 17:46:05 +0100
Message-ID: <w51mv2y30he.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 25/25] block/null: Generate
 filename even with latency-ns
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

On Mon 20 Nov 2017 09:10:04 PM CET, Max Reitz wrote:
> While we cannot represent the latency-ns option in a filename, it is not
> a significant option so not being able to should not stop us from
> generating a filename nonetheless.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
