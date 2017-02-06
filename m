Received: from eggs.gnu.org ([2001:4830:134:3::10]:55978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1carYr-0006X0-Gt
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 17:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1carYq-00040S-OX
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 17:15:01 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1carYq-00040F-Hn
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 17:15:00 -0500
Received: by mail-wm0-x235.google.com with SMTP id r141so132253883wmg.1
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 14:15:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <028cef8c-2f84-b98a-b914-ed9f5c98acfc@redhat.com>
References: <165854135.894789.1486069129896.JavaMail.zimbra@research.iiit.ac.in>
	<20170203152407.GH642@stefanha-x1.localdomain>
	<028cef8c-2f84-b98a-b914-ed9f5c98acfc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Feb 2017 22:14:38 +0000
Message-ID: <CAFEAcA8fp+LS_GeQe_yvGc32QvRenGuFWyVLoU5Lr_=oxBMpwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] regarding codebase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Shubham Kumar <kumar.shubham@research.iiit.ac.in>, QEMU Developers <qemu-devel@nongnu.org>

On 6 February 2017 at 19:51, Eric Blake <eblake@redhat.com> wrote:
> In fact, I seriously doubt ANYONE knows the entire code base.  Rather,
> various people are experts in a subset of the code base; the MAINTAINERS
> file is a good mapping of where to direct questions about a particular
> file.

...which means "mail the mailing list and cc the maintainer",
not "mail the maintainer only in private email", by the way.
Using the mailing lists helps to keep the information public
for others' benefit and means that anybody who happens to
know the answer can provide it.

thanks
-- PMM
