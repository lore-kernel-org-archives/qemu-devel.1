Received: from eggs.gnu.org ([2001:4830:134:3::10]:49111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eLsNE-0003R6-PK
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eLsNE-0007pI-39
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:09:36 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171120201004.14999-18-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-18-mreitz@redhat.com>
Date: Mon, 04 Dec 2017 16:09:30 +0100
Message-ID: <w51374q4jit.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 17/25] iotests: Add quorum case
 to test 110
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

On Mon 20 Nov 2017 09:09:56 PM CET, Max Reitz wrote:
> Test 110 tests relative backing filenames for complex BDS trees.  Now
> that the originally supposedly failing test passes, let us add a new
> failing test: Quorum can never work automatically (without detecting
> whether all child nodes have the same base directory, but that would be
> rather inconsistent behavior).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
