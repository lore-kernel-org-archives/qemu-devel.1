Received: from eggs.gnu.org ([2001:4830:134:3::10]:35055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn0BF-0006ej-MM
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn0BB-0004Ds-Pd
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:25:05 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dn0BB-0004DA-JQ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:25:01 -0400
Received: by mail-wm0-x233.google.com with SMTP id u126so6946240wmg.1
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 03:25:01 -0700 (PDT)
Date: Wed, 30 Aug 2017 11:24:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830102457.GH24565@stefanha-x1.localdomain>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-6-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830082702.3011-6-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/13] hvf: add fields to CPUState and
 CPUX86State; add definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 03:26:54AM -0500, Sergio Andres Gomez Del Real wrote:
> This commit adds some fields specific to hvf in CPUState and
> CPUX86State. It also adds some handy #defines.
> 
> Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
> ---
>  include/qom/cpu.h |  2 ++
>  target/i386/cpu.h | 23 +++++++++++++++++++++++
>  2 files changed, 25 insertions(+)

My comments from v1 were not addressed:
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg05602.html
