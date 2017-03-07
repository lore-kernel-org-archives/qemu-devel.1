Received: from eggs.gnu.org ([2001:4830:134:3::10]:47874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cl9b7-0002eo-8j
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cl9b6-0000tB-89
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:31:53 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cl9b5-0000sy-W3
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:31:52 -0500
Received: by mail-wr0-x22e.google.com with SMTP id u108so132490139wrb.3
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 23:31:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Mar 2017 07:31:30 +0000
Message-ID: <CAFEAcA8JSDHsOFvpPcrv3=PbEiHF5nog1AFOCEpT8QmqDhMttg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL RESEND 00/19] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 March 2017 at 05:25, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 17783ac828adc694d986698d2d7014aedfeb48c6:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.9-20170303' into staging (2017-03-04 16:31:14 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to f0aabd5c4ae11fde704d138e8f06c69e5c902a16:
>
>   net/filter-mirror: Follow CODING_STYLE (2017-03-06 11:46:02 +0800)
>
> ----------------------------------------------------------------
> Preview pull does not reach list.
>
> - fix vlan issues for e1000e
> - convert to use vmstate for vmxnet3
> - several fixes for colo
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
