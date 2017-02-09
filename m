Received: from eggs.gnu.org ([2001:4830:134:3::10]:41863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cbooF-0007b8-U9
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cbooC-000408-00
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:30:51 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170126101827.22378-3-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-3-berrange@redhat.com>
Date: Thu, 09 Feb 2017 14:30:43 +0100
Message-ID: <w51inoj8pa4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 02/18] block: add ability
 to set a prefix for opt names
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

On Thu 26 Jan 2017 11:18:11 AM CET, Daniel P. Berrange wrote:
> When integrating the crypto support with qcow/qcow2, we don't
> want to use the bare LUKS option names "hash-alg", "key-secret",
> etc. We want to namespace them "luks-hash-alg", "luks-key-secret"
> so that they don't clash with any general qcow options at a later
> date.
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
