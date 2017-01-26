Received: from eggs.gnu.org ([2001:4830:134:3::10]:41766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cWnhB-0002bs-UZ
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cWnh7-0006TF-CV
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:18:49 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cWnh7-0006Sr-6Z
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:18:45 -0500
Received: by mail-pf0-x242.google.com with SMTP id 19so16792557pfo.3
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 09:18:45 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170123021748.13170-1-rth@twiddle.net>
	<20170123021748.13170-22-rth@twiddle.net>
	<d010ae34-9ddd-d5fc-1fa0-82d3d2341c95@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <60e14442-ec29-1f43-a6c7-96baabc78a8e@twiddle.net>
Date: Thu, 26 Jan 2017 09:18:41 -0800
MIME-Version: 1.0
In-Reply-To: <d010ae34-9ddd-d5fc-1fa0-82d3d2341c95@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 21/26] target-hppa: Implement branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 01/26/2017 04:14 AM, Paolo Bonzini wrote:
> I haven't studied the code much, so I'm just reporting what Coverity
> says.  Not sure if the code has a bug or can just be simplified.

It looks like it can be simplified.

I'm sure at one point in the development, "which" was not a constant like that.


r~
