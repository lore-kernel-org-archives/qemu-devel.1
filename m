Received: from eggs.gnu.org ([2001:4830:134:3::10]:40854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chIJl-0008Al-IL
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chIJk-00025c-Tu
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:02:01 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chIJk-00025U-NN
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:02:00 -0500
Received: by mail-wm0-x22d.google.com with SMTP id v77so17862482wmv.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 08:02:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486976352-549-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1486976352-549-1-git-send-email-nikunj@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 16:01:39 +0000
Message-ID: <CAFEAcA_TaQf7H=qc6wCHrT88XFTo21i7L9=PHTNFpySA0YCOSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/2] risu_ppc64le: fix the typo nb => rb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>

On 13 February 2017 at 08:59, Nikunj A Dadhania
<nikunj@linux.vnet.ibm.com> wrote:
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  ppc64.risu | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, applied to risu master.

PS: I nearly missed this patchset entirely, because it doesn't have
a cover letter. If you could provide cover letters for multi-patch
series in future that would be really helpful.

thanks
-- PMM
