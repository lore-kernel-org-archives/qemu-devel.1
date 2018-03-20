Received: from eggs.gnu.org ([2001:4830:134:3::10]:49025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyMXW-0005xK-EJ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 15:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyMXV-0006CC-JY
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 15:03:18 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:43992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyMXV-0006C1-Dp
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 15:03:17 -0400
Received: by mail-ot0-x235.google.com with SMTP id m22-v6so2945275otf.10
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 12:03:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180320124117.40573-1-dgilbert@redhat.com>
References: <20180320124117.40573-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 19:02:56 +0000
Message-ID: <CAFEAcA9vG51UOBykQvaLxbji1FbgRaGpZiO=wYVEi0W3VHN4CA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, jixiang_zhang@h3c.com

On 20 March 2018 at 12:41, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 4bdc24fa018901892bb8a5bd1808ebd605f4c6=
4d:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-qapi-2018-03-12-v=
4' into staging (2018-03-20 09:51:49 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-hmp-20180320
>
> for you to fetch changes up to 95372184b7acdfd82ee748b6f0c6df1d839982ba:
>
>   hmp: free sev info (2018-03-20 12:32:06 +0000)
>
> ----------------------------------------------------------------
> HMP fixes for 2.12
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (1):
>       hmp: free sev info
>
> zhangjixiang (1):
>       HMP: Initialize err before using
>

Applied, thanks.

-- PMM
