Received: from eggs.gnu.org ([2001:4830:134:3::10]:56360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtxDo-0006bm-Mv
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtxDk-00068y-Mj
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:40:28 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:54859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dtxDk-00068c-GN
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:40:24 -0400
Received: by mail-wr0-x235.google.com with SMTP id g29so676481wrg.11
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 07:40:24 -0700 (PDT)
Date: Mon, 18 Sep 2017 15:40:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170918144021.GC4141@stefanha-x1.localdomain>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<150529666493.10902.14830445134051381968.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <150529666493.10902.14830445134051381968.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Sep 13, 2017 at 12:57:45PM +0300, Lluís Vilanova wrote:
> +Event instrumentation
> +M: Lluís Vilanova <vilanova@ac.upc.edu>
> +M: Stefan Hajnoczi <stefanha@redhat.com>
> +S: Maintained
> +F: docs/instrument.txt

Thanks for including me but I'm afraid I don't have time to co-maintain
the instrumentation API.

You could maintain it yourself.  Maintainers send signed pull requests
to Peter Maydell to get commits merged into qemu.git/master.

Maybe someone else would like to co-maintain it with you?

Stefan
