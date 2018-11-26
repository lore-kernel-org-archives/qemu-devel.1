Received: from eggs.gnu.org ([2001:4830:134:3::10]:52719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gROVZ-0008FO-EN
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gROVY-0006mz-PR
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:33:33 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1543226303-5260-1-git-send-email-liq3ea@gmail.com>
	<87mupw3vm2.fsf@linaro.org>
	<733cd094-3775-ba2f-242d-e58bc7f2daaa@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7b4d2a9a-a4ed-1f12-f1f6-e5db1d5bd704@twiddle.net>
Date: Mon, 26 Nov 2018 13:33:17 -0800
MIME-Version: 1.0
In-Reply-To: <733cd094-3775-ba2f-242d-e58bc7f2daaa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target: hax: fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>
Cc: ehabkost@redhat.com, qemu-trivial@nongnu.org, laurent@vivier.eu, pbonzini@redhat.com

On 11/26/18 1:25 PM, Philippe Mathieu-Daudé wrote:
>>> -     * 1. The hax_tunnel is also destroied when vcpu destroy
>>> +     * 1. The hax_tunnel is also destroyed when vcpu destroy
> I'm not native english speaker. Isn't it:
> 
> 'The hax_tunnel is also destroyed at vcpu destroy'
> 
> or
> 
> 'The hax_tunnel is also destroyed when vcpu is destroyed'?

This second option is best, fwiw.


r~
