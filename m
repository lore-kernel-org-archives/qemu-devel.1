Received: from eggs.gnu.org ([2001:4830:134:3::10]:33057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpuOM-0007yo-V8
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpuOM-0007Rf-5g
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:50:39 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:38621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpuOL-0007RG-VE
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:50:38 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 108so18551254wra.5
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 03:50:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170906140246.7326-1-kwolf@redhat.com>
References: <20170906140246.7326-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 11:50:15 +0100
Message-ID: <CAFEAcA9wkNJ3wACJg0siin8m5b-S=FGxrbMaxqe5UVgchfE-dA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 6 September 2017 at 15:02, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 98bfaac788be0ca63d7d010c8d4ba100ff1d8278:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-09-01-v3' into staging (2017-09-04 13:28:09 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 83a8c775a8bf134eb18a719322939b74a818d750:
>
>   qcow2: move qcow2_store_persistent_dirty_bitmaps() before cache flushing (2017-09-06 14:40:18 +0200)
>
> ----------------------------------------------------------------
> Block layer patches
>

Applied, thanks.

-- PMM
