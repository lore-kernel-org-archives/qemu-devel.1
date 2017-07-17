Received: from eggs.gnu.org ([2001:4830:134:3::10]:59660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXAu8-0006GE-1W
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXAu7-0008AI-BR
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:38:00 -0400
References: <20170627154120.20346-1-stefanha@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e711b03d-4543-be7d-24ef-c8eb7817cc41@redhat.com>
Date: Mon, 17 Jul 2017 14:37:49 -0400
MIME-Version: 1.0
In-Reply-To: <20170627154120.20346-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] docs: add
 qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org



On 06/27/2017 11:41 AM, Stefan Hajnoczi wrote:
> Block driver documentation is available in qemu-doc.html.  It would be
> convenient to have documentation for formats, protocols, and filter
> drivers in a man page.
> 
> Extract the relevant part of qemu-doc.html into a new file called
> docs/qemu-block-drivers.texi.  This file can also be built as a
> stand-alone document (man, html, etc).
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---

Ping for 2.10, or no?

--js
