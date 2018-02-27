Received: from eggs.gnu.org ([2001:4830:134:3::10]:43299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqfiL-0007Pc-He
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqfiK-0005Ln-RH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:54:41 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180224154033.29559-2-mreitz@redhat.com>
References: <20180224154033.29559-1-mreitz@redhat.com>
	<20180224154033.29559-2-mreitz@redhat.com>
Date: Tue, 27 Feb 2018 14:33:51 +0100
Message-ID: <w51606i4kw0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/7] compiler: Add QEMU_BUILD_BUG_MSG()
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Sat 24 Feb 2018 04:40:27 PM CET, Max Reitz wrote:
> _Static_assert() allows us to specify messages, and that may come in
> handy.  Even without _Static_assert(), encouraging developers to put a
> helpful message next to the QEMU_BUILD_BUG_* may make debugging easier
> whenever it breaks.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
