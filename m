Received: from eggs.gnu.org ([2001:4830:134:3::10]:60739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dV62v-00047W-Q6
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 21:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dV62r-0007nu-Tb
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 21:02:29 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:35663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dV62r-0007nh-OU
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 21:02:25 -0400
Received: by mail-pg0-x22f.google.com with SMTP id j186so4291758pge.2
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 18:02:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170711015524.22936-1-f4bug@amsat.org>
	<12cda13a-cdba-c480-6f6c-67811135a8a1@twiddle.net>
	<CAAdtpL6dNsEtutF3Tj0s1X-ZYepMWfLYNsAUMsgcA=BTvdLDiw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0ddcadab-af60-a45b-0ce0-8b6eecc6101d@twiddle.net>
Date: Tue, 11 Jul 2017 15:02:18 -1000
MIME-Version: 1.0
In-Reply-To: <CAAdtpL6dNsEtutF3Tj0s1X-ZYepMWfLYNsAUMsgcA=BTvdLDiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] util/cacheinfo: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Geert Martin Ijewski <gm.ijewski@web.de>

On 07/10/2017 05:27 PM, Philippe Mathieu-Daudé wrote:
>> For the record, what is the os version?
>> Because this doesn't happen here for Centos7.
> Oops true I forgot to log this info in the commit.
> 
> This happens on debian/powerpc Jessie, using GCC 4.9.2-10

Thanks.  Queued to tcg-next.


r~
