Received: from eggs.gnu.org ([2001:4830:134:3::10]:40237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQZA9-0000ac-Je
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQZA6-000448-8S
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:07:13 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:34930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQZA6-00043T-4W
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:07:10 -0400
Received: by mail-qt0-x234.google.com with SMTP id f92so73452694qtb.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 06:07:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170621154244.28309-1-alex.bennee@linaro.org>
	<20170621154244.28309-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <42ab61f5-47f3-030d-264b-78d3f11d8e20@amsat.org>
Date: Thu, 29 Jun 2017 10:07:06 -0300
MIME-Version: 1.0
In-Reply-To: <20170621154244.28309-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v6 02/10] build-all-archs: support
 cross building via docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

Hi Alex,

On 06/21/2017 12:42 PM, Alex Bennée wrote:> By default we use the QEMU 
projects qemu:debian-FOO-cross images as
> RISU hackers are likely to be QEMU developers too. However any docker
> tag can be passed on the command line.

Any thought about starting to push images?
