Received: from eggs.gnu.org ([2001:4830:134:3::10]:34383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccBtQ-000365-3y
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccBtP-0002t2-8K
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:09:44 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:32985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccBtP-0002sf-1y
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:09:43 -0500
Received: by mail-wr0-x234.google.com with SMTP id i10so108821065wrb.0
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 06:09:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486619931-1086-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1486619931-1086-1-git-send-email-nikunj@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 14:09:21 +0000
Message-ID: <CAFEAcA_iaRPoW6S9=XB_QmbSC9igb8VH9eHr---iYSVPZEtutw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/3] Risu PPC improvements
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

On 9 February 2017 at 05:58, Nikunj A Dadhania
<nikunj@linux.vnet.ibm.com> wrote:
> The series contains some fixes/cleanup for ppc64le
>
> Nikunj A Dadhania (3):
>   risu_ppc64le: set r23 as the comment says
>   risu_ppc64le: zero the xer register
>   risu_ppc64le: remove aarch64 related comments
>
>  risugen_ppc64.pm | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied to risu master, thanks.

-- PMM
