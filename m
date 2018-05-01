Received: from eggs.gnu.org ([2001:4830:134:3::10]:58261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDbeA-00070D-Bq
	for qemu-devel@nongnu.org; Tue, 01 May 2018 16:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDbe7-0007cQ-1f
	for qemu-devel@nongnu.org; Tue, 01 May 2018 16:13:10 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDbe6-0007bx-QM
	for qemu-devel@nongnu.org; Tue, 01 May 2018 16:13:06 -0400
Received: by mail-pf0-x242.google.com with SMTP id a14so9854855pfi.1
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 13:13:06 -0700 (PDT)
References: <20180411192347.30228-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b90e6ee8-7afc-bb3b-327c-3aa93138df96@linaro.org>
Date: Tue, 1 May 2018 13:13:02 -0700
MIME-Version: 1.0
In-Reply-To: <20180411192347.30228-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.13] linux-user: introduce
 target_sigsp() and target_save_altstack()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 04/11/2018 12:23 PM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> Based-on: <20180411185651.21351-1-laurent@vivier.eu>
> "[PATCH for 2.13 v2 00/19] linux-user: move arch specific parts from main.c to arch directories"

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
