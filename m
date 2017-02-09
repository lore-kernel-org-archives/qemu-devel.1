Received: from eggs.gnu.org ([2001:4830:134:3::10]:44433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cbnFg-0003v4-Rk
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cbnFd-0004ou-Np
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:51:04 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170126101827.22378-7-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-7-berrange@redhat.com>
Date: Thu, 09 Feb 2017 12:50:59 +0100
Message-ID: <w51lgtf8twc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 06/18] iotests: skip 048
 with qcow which doesn't support resize
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

On Thu 26 Jan 2017 11:18:15 AM CET, Daniel P. Berrange wrote:
> Test 048 is designed to verify data preservation during an
> image resize. The qcow (v1) format impl has never supported
> resize so always fails.
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
