Received: from eggs.gnu.org ([2001:4830:134:3::10]:59554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtBOT-0006SE-UH
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 07:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtBOS-0003zN-OA
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 07:36:17 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:52146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dtBOS-0003xW-Gw
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 07:36:16 -0400
Received: by mail-wr0-x229.google.com with SMTP id z39so3351030wrb.8
	for <qemu-devel@nongnu.org>; Sat, 16 Sep 2017 04:36:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170915084139.4481-1-otubo@redhat.com>
References: <20170915084139.4481-1-otubo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Sep 2017 12:35:54 +0100
Message-ID: <CAFEAcA9R3q-FSX_EsH43cH56Y+Tb5+9ruwu4ha6iJDr=XbiQcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/06] seccomp branch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On 15 September 2017 at 09:41, Eduardo Otubo <otubo@redhat.com> wrote:
> The following changes since commit 3dabde1128b671f36ac6cb36b97b273139964420:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20170914' into staging (2017-09-14 16:33:02 +0100)
>
> are available in the git repository at:
>
>   https://github.com/otubo/qemu.git tags/pull-seccomp-20170915
>
> for you to fetch changes up to c3883e1f935bf11ef0d2b8157b0022ace3d0e77d:
>
>   buildsys: Move seccomp cflags/libs to per object (2017-09-15 10:16:05 +0200)
>
> ----------------------------------------------------------------
> pull-seccomp-20170915
>
> ----------------------------------------------------------------
> Eduardo Otubo (5):
>       seccomp: changing from whitelist to blacklist
>       seccomp: add obsolete argument to command line
>       seccomp: add elevateprivileges argument to command line
>       seccomp: add spawn argument to command line
>       seccomp: add resourcecontrol argument to command line
>
> Fam Zheng (1):
>       buildsys: Move seccomp cflags/libs to per object

Applied, thanks.

-- PMM
