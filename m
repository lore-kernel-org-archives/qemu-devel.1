Received: from eggs.gnu.org ([2001:4830:134:3::10]:36769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cm1BA-00056M-Qg
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cm1B6-0000ro-ED
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:44:40 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cm1B6-0000rg-66
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:44:36 -0500
Received: by mail-wm0-x22e.google.com with SMTP id t189so60604358wmt.1
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 08:44:36 -0800 (PST)
References: <1221104956.3749086.1489075142127.ref@mail.yahoo.com>
	<1221104956.3749086.1489075142127@mail.yahoo.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1221104956.3749086.1489075142127@mail.yahoo.com>
Date: Thu, 09 Mar 2017 16:44:45 +0000
Message-ID: <874lz2iema.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] about restore the pc of the guest code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: oussema ben khedher <oussemakeder@yahoo.fr>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


oussema ben khedher <oussemakeder@yahoo.fr> writes:

> hi
>
> i search the pc of tb in the guest code i used the function
> cpu_restore_state_from_tb in cpu_exec_tb but the searching pc take 0
> value can someone explain me why searching_pc is 0 or give me some
> hints

Have you got a backtrace of how you got there?

--
Alex Bennée
