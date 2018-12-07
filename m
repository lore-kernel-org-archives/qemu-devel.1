Received: from eggs.gnu.org ([2001:4830:134:3::10]:46302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVIzE-00047Q-SA
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVIz6-00080V-Ck
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:28:16 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVIz3-0007hn-4F
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:28:09 -0500
Received: by mail-ot1-x343.google.com with SMTP id t5so4331496otk.1
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 08:28:07 -0800 (PST)
References: <1543937577-28256-1-git-send-email-thuth@redhat.com>
	<1543937577-28256-3-git-send-email-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c60eabcc-0d3d-8518-e97e-c0b998508f48@linaro.org>
Date: Fri, 7 Dec 2018 10:28:03 -0600
MIME-Version: 1.0
In-Reply-To: <1543937577-28256-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 2/7] configure: Remove obsolete
 check for Clang < 3.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>

On 12/4/18 9:32 AM, Thomas Huth wrote:
> Since we have got a check for Clang >= 3.4 now, we do not need to
> check for older Clang versions in the configure test for 128-bit ints
> anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
