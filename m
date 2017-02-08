Received: from eggs.gnu.org ([2001:4830:134:3::10]:43247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cbUCs-0002ks-DT
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 10:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cbUCn-0000BV-GV
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 10:30:54 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170126101827.22378-4-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-4-berrange@redhat.com>
Date: Wed, 08 Feb 2017 16:30:47 +0100
Message-ID: <w51mvdwsnrs.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 03/18] qcow: document
 another weakness of qcow AES encryption
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

On Thu 26 Jan 2017 11:18:12 AM CET, Daniel P. Berrange wrote:
> Document that use of guest virtual sector numbers as the basis for
> the initialization vectors is a potential weakness, when combined
> with internal snapshots or multiple images using the same passphrase.
> This fixes the formatting of the itemized list too.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
