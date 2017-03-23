Received: from eggs.gnu.org ([2001:4830:134:3::10]:45662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr7o7-0006w2-Ax
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr7o6-0004eU-Kd
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:49:59 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cr7o6-0004eA-EM
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:49:58 -0400
Received: by mail-wm0-x229.google.com with SMTP id n11so4041947wma.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 11:49:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170323085829.GM16717@stefanha-x1.localdomain>
References: <1490119729-26206-1-git-send-email-peter.maydell@linaro.org>
	<20170323085829.GM16717@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Mar 2017 18:49:36 +0000
Message-ID: <CAFEAcA9e+hFH63WAdkO8N_64JROdXT7RDU8tEfdX2LKJm5XnUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] configure: Fix cut-n-paste errors in OS
 deprecation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 23 March 2017 at 08:58, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Mar 21, 2017 at 06:08:49PM +0000, Peter Maydell wrote:
>> Fix some cut-and-paste errors in the OS deprecation warning
>> pointed out by Thomas Huth.
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  configure | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks; applied to master.

-- PMM
