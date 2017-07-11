Received: from eggs.gnu.org ([2001:4830:134:3::10]:56311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUsFu-0003KI-Rg
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUsFu-0001N0-4c
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:18:58 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:34433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUsFt-0001Mb-UZ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:18:58 -0400
Received: by mail-wr0-x22f.google.com with SMTP id 77so176608997wrb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 03:18:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498927637-14496-2-git-send-email-drjones@redhat.com>
References: <1498927637-14496-1-git-send-email-drjones@redhat.com>
	<1498927637-14496-2-git-send-email-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 11:18:36 +0100
Message-ID: <CAFEAcA-xAxe88XmyrhjbQ6t24=xBey2+XE2wwSvfO4+u1wZ_EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/arm/virt: add pmu interrupt state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alexander Graf <agraf@suse.de>

On 1 July 2017 at 17:47, Andrew Jones <drjones@redhat.com> wrote:
> Mimicking gicv3-maintenance-interrupt, add the PMU's interrupt to
> CPU state.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
