Received: from eggs.gnu.org ([2001:4830:134:3::10]:43996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cbnCo-0001uK-7E
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cbnCk-0003xz-Tr
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:48:06 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170126101827.22378-6-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-6-berrange@redhat.com>
Date: Thu, 09 Feb 2017 12:47:58 +0100
Message-ID: <w51o9yb8u1d.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 05/18] iotests: skip 042
 with qcow which dosn't support zero sized images
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

On Thu 26 Jan 2017 11:18:14 AM CET, Daniel P. Berrange wrote:
> Test 042 is designed to verify operation with zero sized images.
> Such images are not supported with qcow (v1), so this test has
> always failed.
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
