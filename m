Received: from eggs.gnu.org ([2001:4830:134:3::10]:51719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGjV-0003y6-FQ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGjU-0006Fe-N0
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:02:05 -0500
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:38059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epGjU-0006EP-Gv
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:02:04 -0500
Received: by mail-pg0-x231.google.com with SMTP id l24so3579103pgc.5
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:02:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223164937.GG31076@redhat.com>
References: <20180223154613.2096-1-alex.bennee@linaro.org>
	<20180223154613.2096-5-alex.bennee@linaro.org>
	<20180223161723.GF31076@redhat.com> <878tbjac3d.fsf@linaro.org>
	<20180223164937.GG31076@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 17:01:42 +0000
Message-ID: <CAFEAcA-r7o=yMD+Mvo0-3Lpfe-Vvs_SdKOnJoOFnuNJn1oEdLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/8] new contrib/generate_all.sh: batch
 risugen script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 23 February 2018 at 16:49, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> If it is going to live in QEMU source tree, then avoiding introducing a n=
ew
> license is desirable.

It isn't -- risu has its own repository.

thanks
-- PMM
