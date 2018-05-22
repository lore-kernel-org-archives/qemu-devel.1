Received: from eggs.gnu.org ([2001:4830:134:3::10]:42416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLBg0-000697-M2
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLBfw-0008SG-Kk
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:06:24 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-17-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <23332ec0-bf12-7e04-8261-533c52c3f314@twiddle.net>
Date: Tue, 22 May 2018 11:06:16 -0700
MIME-Version: 1.0
In-Reply-To: <20180521140402.23318-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/27] iommu: Add IOMMU index argument to
 translate method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/21/2018 07:03 AM, Peter Maydell wrote:
> Add an IOMMU index argument to the translate method of
> IOMMUs. Since all of our current IOMMU implementations
> support only a single IOMMU index, this has no effect
> on the behaviour.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
