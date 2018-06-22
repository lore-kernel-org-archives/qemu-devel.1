Received: from eggs.gnu.org ([2001:4830:134:3::10]:44204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fWLEI-0003Zd-8T
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fWLEF-0005RS-42
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:31:54 -0400
Date: Fri, 22 Jun 2018 14:31:49 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180622123149.qxirhe6uajzkc22s@sirius.home.kraxel.org>
References: <20180621171257.14897-1-f4bug@amsat.org>
	<20180621171257.14897-6-f4bug@amsat.org>
	<20180622062225.ay4bubgshxjj3uey@sirius.home.kraxel.org>
	<3a5e52f6-3b65-5ce8-f5d2-48b76e3e4f21@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5e52f6-3b65-5ce8-f5d2-48b76e3e4f21@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 05/11] hw/display/cirrus: Convert printf()
 calls to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

> > Indention looks weird.
> 
> Actually this is the code around that is weirdly intended, a mix of
> <tab> and <spaces>.

Ok.

> Do you prefer a previous indent cleanup patch or can I add your Acked-by
> tag?

Leave as is.  Breaking "git blame" with a whitespace cleanup is not
useful indeed.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd
