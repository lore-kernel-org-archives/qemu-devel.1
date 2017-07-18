Received: from eggs.gnu.org ([2001:4830:134:3::10]:57518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXTP9-0004vL-6a
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXTP8-0003YJ-9u
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:23:15 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXTP8-0003Xx-27
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:23:14 -0400
Received: by mail-wr0-x22c.google.com with SMTP id v105so1557731wrb.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 07:23:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500375704-28002-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1500375704-28002-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 15:22:52 +0100
Message-ID: <CAFEAcA-oPSoSBdJ0zdOQA0HAyBec51N743cNW+=Rjk8xZmckiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/8] qemu-ga patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 July 2017 at 12:01, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> The following changes since commit ca4e667dbf431d4a2a5a619cde79d30dd2ac3eb2:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170717-pull-request' into staging (2017-07-17 17:54:17 +0100)
>
> are available in the git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2017-07-17-v2-tag
>
> for you to fetch changes up to 339ca68bef9f30dd18e84b7d92398327e3f819a3:
>
>   test-qga: add test for guest-get-osinfo (2017-07-18 05:49:01 -0500)
>
> ----------------------------------------------------------------
> qemu-ga patch queue
>
> * new command: qemu-get-osinfo
> * build fix for OpenBSD
> * better error-reporting for failure on keyfile dump
> * remove redundant initialization of qa_state global
> * include libpcre in w32 package
> * w32 localization fixes for service installation/registration
>
> v2:
> * fix build issue with older GCCs introduced with guest_get_osinfo
> * relocated some declarations in guest_get_osinfo
>

Applied, thanks.

-- PMM
