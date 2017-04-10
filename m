Received: from eggs.gnu.org ([2001:4830:134:3::10]:35815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxawM-0005pc-4J
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxawK-0003I1-Uq
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:09:14 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxawK-0003Hi-Nm
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:09:12 -0400
Received: by mail-wm0-x22b.google.com with SMTP id o81so41491944wmb.1
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 08:09:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170410125524.21008-1-alex.bennee@linaro.org>
References: <20170410125524.21008-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 16:08:50 +0100
Message-ID: <CAFEAcA_N5BcsquzqFXO1wJ5FpKcRAWWfaqOQsgXp=8bGeJwJow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/11] Final icount and misc MTTCG fixes for
 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10 April 2017 at 13:55, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The following changes since commit 5fe2339e6b09da7d6f48b9bef0f1a7360392b4=
89:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-201704=
06.0' into staging (2017-04-07 10:29:56 +0100)
>
> are available in the git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-mttcg-fixups-for-rc2-1004=
17-1
>
> for you to fetch changes up to 982263ce714ffcc4c7c41a7b255bd29e093912fe:
>
>   replay: assert time only goes forward (2017-04-10 10:23:38 +0100)
>
> ----------------------------------------------------------------
> Final icount and misc MTTCG fixes for 2.9
>
> Minor differences from:
>   Message-Id: <20170405132503.32125-1-alex.bennee@linaro.org>
>
>   - dropped new feature patches
>   - last minute typo fix from Nikunj A Dadhania <nikunj@linux.vnet.ibm.co=
m>
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
