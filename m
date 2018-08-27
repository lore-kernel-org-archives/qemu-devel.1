Received: from eggs.gnu.org ([2001:4830:134:3::10]:49324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fuKmb-0005Mp-Lt
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 12:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fuKmZ-0002Yp-UT
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 12:54:29 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:39185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fuKmZ-0002XW-EJ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 12:54:27 -0400
Received: by mail-oi0-x231.google.com with SMTP id c190-v6so28500231oig.6
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 09:54:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180827134842.12238-1-armbru@redhat.com>
References: <20180827134842.12238-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Aug 2018 17:54:06 +0100
Message-ID: <CAFEAcA9ujNnFv-VVsq--H7jD8cau3vG=Pqj_7Mdy8J3ca6u7Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/3] Error reporting patches for
 2018-08-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 August 2018 at 14:48, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 235c82acca0491465e94be3cae2583b42d37c859:
>
>   Merge remote-tracking branch 'remotes/otubo/tags/pull-seccomp-20180823' into staging (2018-08-25 13:08:57 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2018-08-27-v2
>
> for you to fetch changes up to 4e4abd111a2af0179a4467368d695958844bf113:
>
>   intel-iommu: replace more vtd_err_* traces (2018-08-27 15:09:20 +0200)
>
> ----------------------------------------------------------------
> Error reporting patches for 2018-08-27
>
> * Provide error_report_once(), along with first users
>
> ----------------------------------------------------------------
> Peter Xu (3):
>       qemu-error: introduce {error|warn}_report_once
>       intel-iommu: start to use error_report_once
>       intel-iommu: replace more vtd_err_* traces

Applied, thanks.

-- PMM
