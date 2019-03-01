Received: from eggs.gnu.org ([209.51.188.92]:43649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzf0d-0001ZG-5M
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzf0c-0001OS-Al
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:03:15 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzf0b-0001N4-Sw
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:03:14 -0500
Received: by mail-wm1-x341.google.com with SMTP id o10so8457274wmc.1
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 02:03:13 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  1 Mar 2019 10:03:05 +0000
Message-Id: <20190301100310.22345-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v2 0/5] gitdm/next updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

I misidentified a bunch of individual contributors as academics in the
last series so I've fixed that now. I've also added Janus Technologies
for Marcus. If everyone is happy with these changes I'll send in the
PR.

The following patches need review
 patch 0003/contrib gitdm add more individual contributors.patch
 patch 0005/contrib gitdm add a mapping for Janus Technologie.patch


Aleksandar Markovic (2):
  contrib: gitdm: Update domain-map
  contrib: gitdm: Update Wave Computing group

Alex Bennée (3):
  contrib: gitdm: add more individual contributors
  contrib: gitdm: another IBM email
  contrib: gitdm: add a mapping for Janus Technologies

 contrib/gitdm/domain-map            |  5 +++++
 contrib/gitdm/group-map-ibm         |  1 +
 contrib/gitdm/group-map-individuals |  5 +++++
 contrib/gitdm/group-map-janustech   |  5 +++++
 contrib/gitdm/group-map-wavecomp    | 12 ++++++++++++
 gitdm.config                        |  1 +
 6 files changed, 29 insertions(+)
 create mode 100644 contrib/gitdm/group-map-janustech

-- 
2.20.1
