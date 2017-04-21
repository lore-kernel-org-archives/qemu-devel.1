Received: from eggs.gnu.org ([2001:4830:134:3::10]:36173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1YCb-0006gW-9T
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1YCa-0003hb-Ir
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:02:21 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1YCa-0003hG-Bi
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:02:20 -0400
Received: by mail-wr0-x22c.google.com with SMTP id w50so31042727wrc.0
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 06:02:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170421074038.774-1-cornelia.huck@de.ibm.com>
References: <20170421074038.774-1-cornelia.huck@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Apr 2017 14:01:58 +0100
Message-ID: <CAFEAcA9e9axXnpDNBoGTgJi1XSwYrTp+fhuY8v2Tq20y18CSYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/11] s390x patches for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

On 21 April 2017 at 08:40, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> The following changes since commit da92ada855036c55bd08b0b0c64c7551d56f3586:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170420' into staging (2017-04-20 17:41:34 +0100)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170421
>
> for you to fetch changes up to cb55c19a26d6928b445f1bd9394843c9eb60f8ab:
>
>   s390x: Drop useless casts (2017-04-21 09:32:09 +0200)
>
> ----------------------------------------------------------------
> The first batch of s390x changes for 2.10:
> - the new compat machine
> - several cleanups and optimizations
> - introspection for css ids
>

Applied, thanks.

-- PMM
