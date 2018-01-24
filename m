Received: from eggs.gnu.org ([2001:4830:134:3::10]:56495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeMAr-0000Wm-Ek
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 09:37:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeMAn-00041H-Io
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 09:37:13 -0500
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:46656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeMAn-000414-F8
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 09:37:09 -0500
Received: by mail-qt0-x232.google.com with SMTP id o35so10741442qtj.13
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 06:37:09 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-13-alex.bennee@linaro.org>
	<4e28f983-0874-c1ac-af3f-bcb614a1f419@amsat.org>
Message-ID: <b8e6556e-1f3c-266f-0fbc-fb78551b7fed@amsat.org>
Date: Wed, 24 Jan 2018 11:37:05 -0300
MIME-Version: 1.0
In-Reply-To: <4e28f983-0874-c1ac-af3f-bcb614a1f419@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 12/22] fpu/softfloat: re-factor add/sub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

> (note for myself, since I need more time for those 3)
> all bug round_canonical() pick_nan_parts() addsub_floats():

haha I check this mail back to copy the function names and read I wrote
"bug", lapsus/typo? :) I obviously meant "all _BUT_ ... :"

> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
